Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4003C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 02:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTAAM-0004E5-Ti; Sat, 21 Jun 2025 22:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAAJ-0004DW-Qm
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:10:39 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAAI-0000nd-9o
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:10:39 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-748f54dfa5fso2146828b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 19:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750558236; x=1751163036; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U3EAV4ihhKMluSIs5xLa8MVohaPmVwFpq6gmIPghMaA=;
 b=VIAGFyEOGMk8EEdwOkValBV/i3UIbpIicTJcMtL1s9bX5L6iITuEw+NFxiF43m3xlj
 axUXgTGtKP4lWdDKjL8lpHPmZcmD2p6qFNBdYcheK6ojIKLJ8IEZ91j+16nsEG9yCxXF
 +xBp+5bVFz+XbA4edGO4QtzrjDz6S9tCVTk8TIIYXvDKAJGGUAZ0voziZj6l2zfM7lZI
 jVN/MkYpR6OcX1Z8wSB/Fr7p689wY8FK/g9756OT2vY8jTypunfgmFJP13e4qUbSnILf
 +CzVb1TUqWwKftFmzUBdtCsbKfmjKLVZBmL5A6BY8YMJCK8hW7OLJKNO55sHud3ttntX
 6Rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750558236; x=1751163036;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U3EAV4ihhKMluSIs5xLa8MVohaPmVwFpq6gmIPghMaA=;
 b=OKFcYrpe/vQhhgYpgLR4Jq6ThfI1UWteGrOKTfGUddfMvb/BG7H9FhPzJ8HVMXwYWC
 qK+YD650s8eX0NIIXeXMxIzJBC4IPPXsf77b3ZoxOAFJ2Ak9TKHLsm2uQS1/ZnJbfnsw
 sK7CLTnu07v03218IaYTfny8qcEzomwdhY1IhMIQjw/tF24VUCF8p/cQ2UGRhR7oG70u
 hkcwj0Dvjfs/dCgrRTVUPkfW2utAWhJuMSx0IC2VJdtyVLkDLZg58AXcuIj1NrXANbQr
 pr8Kl5qyPA+OHjqtkxPwL14rssiLwk4qjfYp0BUyck+A9p3IMnPEhUwUZRKCIhTpxQxt
 7xJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHTzxIeek0BMJwrWKNM2DJVZCOR99v5+FxkF592LzgsyBrFxTp2S8sORwO2KAe64UpJ5FNZkPjj/Kh@nongnu.org
X-Gm-Message-State: AOJu0YzLxlf71EpjkoKqP7vDHD8GJRFNGapx2Or6YU6/l3OwxwfVVard
 iAjkjmItNShPa23fUaeIGuRlBVXu0itB8abWdnOZ2CR2pfuWnpYBVBVPD7DSe7ynJGc=
X-Gm-Gg: ASbGncvf2h9VXnnwOsi9759fM01RAbLdvMY95fXEMMTkhf8zKfJjjwFHGsUUuIZNOmp
 l70zx1Uoc54hw8BeFBgiYbfIvNAvSeQ8/hrMctP6AKlaentajIwQwU/mFE+CTucCNOYkRLFtkSh
 /O4Y5Rv3Ct1vdUsON75xqY4uWdHBPv/TnR+Ru0Gko2R7eZ8Wxf65e8vJXyTUPIvJyT9AvyP/wVJ
 BYSLkkzP5KdbEH/arUtbRgIjTujm9fR8lSSwawMEoTewXne1vfcLxWEmMFHZE5tn1gcM8XkJMA4
 fX0JeSvR/hLnZ9zeqXZ2H62VFALXmQFYsxxuw+8qg1gl+zQaVHBEUfXdoIJDHhimTLHzM5RWP02
 r/hVAlPj2dMXWT2fknxCjtZG9jrGK
X-Google-Smtp-Source: AGHT+IE/kCJpoFH/yeJrcU8W7csfoTL8N39jd1Spdb/VLKF/SGNtCQ8JboEyFgm4Bz+DGrL2DpEe2A==
X-Received: by 2002:aa7:88c9:0:b0:748:2e7b:3308 with SMTP id
 d2e1a72fcca58-7490d764201mr11462763b3a.6.1750558236513; 
 Sat, 21 Jun 2025 19:10:36 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a4a34cdsm5325267b3a.67.2025.06.21.19.10.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 19:10:36 -0700 (PDT)
Message-ID: <aea4e119-1ac5-4b03-9639-0dc277375365@linaro.org>
Date: Sat, 21 Jun 2025 19:10:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 36/48] accel/whpx: Convert to
 AccelOpsClass::cpu_thread_routine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-37-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-37-philmd@linaro.org>
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

On 6/20/25 10:13, Philippe Mathieu-Daudé wrote:
> By converting to AccelOpsClass::cpu_thread_routine we can
> let the common accel_create_vcpu_thread() create the thread.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/i386/whpx/whpx-accel-ops.c | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/target/i386/whpx/whpx-accel-ops.c b/target/i386/whpx/whpx-accel-ops.c
> index b8bebe403c9..c1b27d1b89d 100644
> --- a/target/i386/whpx/whpx-accel-ops.c
> +++ b/target/i386/whpx/whpx-accel-ops.c
> @@ -61,16 +61,6 @@ static void *whpx_cpu_thread_fn(void *arg)
>       return NULL;
>   }
>   
> -static void whpx_start_vcpu_thread(CPUState *cpu)
> -{
> -    char thread_name[VCPU_THREAD_NAME_SIZE];
> -
> -    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/WHPX",
> -             cpu->cpu_index);
> -    qemu_thread_create(cpu->thread, thread_name, whpx_cpu_thread_fn,
> -                       cpu, QEMU_THREAD_JOINABLE);
> -}
> -
>   static void whpx_kick_vcpu_thread(CPUState *cpu)
>   {
>       if (!qemu_cpu_is_self(cpu)) {
> @@ -87,7 +77,7 @@ static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
>   {
>       AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
>   
> -    ops->create_vcpu_thread = whpx_start_vcpu_thread;
> +    ops->cpu_thread_routine = whpx_cpu_thread_fn;
>       ops->kick_vcpu_thread = whpx_kick_vcpu_thread;
>       ops->cpu_thread_is_idle = whpx_vcpu_thread_is_idle;
>   

After this, create_vcpu_thread is unused, correct?


r~

