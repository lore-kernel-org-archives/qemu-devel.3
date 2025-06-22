Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C35AC71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 03:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTAyb-0004mM-PQ; Sat, 21 Jun 2025 23:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAya-0004lN-NZ
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:02:36 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAyW-00025L-Qk
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:02:35 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-234d366e5f2so41174795ad.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 20:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750561350; x=1751166150; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MaDF/XsRMIwCMlsB9z40k9o4m+wZUi1U+UQNLS8wV08=;
 b=zErqOwrKumQeMqfmNCD2fstiecfk+VQAstlgKnrGlLyk1aUnukOWEszqVAkEu6eVd5
 F8seWTLHDCVTu8cfLU2sqLOb8JV1t51FHrWwcPAQZjdasSK/56q5qKL878pMSh4wgbGY
 wiRnRc295USU3pj3C9GGMizDnzx8YVd4cy42KcwCWFrOalT1Ktymp9by0Je08VDjVzra
 fI83dhvA22wEjJ32Sjrd3QghqUd/9BJ6tBNDhDVS52Pnei/wwCyZFimJCQPYnXZsdEg1
 4TPTWhAJsuPtPfBZuNeUoDi5cSvrMjqAckp/iJDv0Tj0mJ+WUqXbQDHeYC98kK5UI+9P
 7wWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750561350; x=1751166150;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MaDF/XsRMIwCMlsB9z40k9o4m+wZUi1U+UQNLS8wV08=;
 b=DJB3dXk5aG1HUQ6EKtV4+Y/bvlTkSKwbCT+d9SKmqMEi/X6byd5ESX4iP+mOG6VQhS
 fzggbLowr+knZcjkUy7YtDGRLYMZuaivYpHU4mcBVv7zUCYu+grjfNqagqk//3zZKkpj
 rFCNYQHNNzl8tke0oUs1DWgDqVHQp1oinvtwFR7JYX60F1YU8/g6UGrtocHrEW7SNU6E
 A0YedAfVsKf3U+BcNelt/AqNyAXicCDHs/ZdnzcTY4Y5wBUehnb4C5susiHz2WkYBxZd
 tRKqT4BBYVlnNSo3eXY96OxOEO8P2jv9XG6LAizDs/Irfs5FEbwnNCTw0XOWHMALSEvk
 hoZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhcQrE/1md834nziPv7W8YYbkzEm5Czn/1siiTj/ax0ohOxKWSvVVhVjq/e13CnRmQa0fISmpbZNtS@nongnu.org
X-Gm-Message-State: AOJu0YxcuqYCvzbV/ulQRswAMYt8NfIW68N+rPRTk6dsrkgXCApOeiW9
 AnWTueFNTzz35FiHjmfMwHrB/5NqOCcTEjzl+7NvqVOU6ZGnNJtjRPjwy8ZSwcYcxJ4=
X-Gm-Gg: ASbGncv9y00Nih81RUHSup3P3Ua7g4GZ74MqMFSdUHFMpK0wWwGTSZoUntKabWjYhHA
 vjNUa78AUBXTJrHmeF8NIDS6mHC52SmyHe22nKnYcuQzZJFUhT9HnBqGlZpbhVhgcvIn9c1FpWp
 slg44OJouFtZFbLzyIqGrbU+hCDMFVTlp93XQioWViF6rf4cSkuuS3aCKBq8DU2whW2IDF6w/JG
 /iD38LsO39OGhF7SrrU+bTSbG8FfhpFx2Ff2GDr+fqBdFbtcqlfZ3uD8HB4g9t4UWupKKtrHL75
 CGr7b4gkUKJcaEiKDVzvi262euoKP4PdDyek7EdnyQ6xgRbJWTbDCDjwm71ZWNg2UuIkasmwiJJ
 GGKpV+RiGxS0Y1rpbG9fqXntnp6hE
X-Google-Smtp-Source: AGHT+IHH2C4q4HecWUdIORRFY3mSFEFLkWLmgXOWk8c3AXC2cm0OU44kIBanKgDsIe6X+rkU+/gurg==
X-Received: by 2002:a17:902:ea02:b0:235:eefe:68ec with SMTP id
 d9443c01a7336-237d981d6a3mr128594815ad.19.1750561349831; 
 Sat, 21 Jun 2025 20:02:29 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3159e0488c3sm5461721a91.29.2025.06.21.20.02.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 20:02:29 -0700 (PDT)
Message-ID: <bb526b33-5b07-4e62-b049-a1b3c7911f6b@linaro.org>
Date: Sat, 21 Jun 2025 20:02:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 21/42] accel/split: Set use_hw in
 cpu_thread_routine() and switch over
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-22-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-22-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
> Introduce the EXCP_HWACCEL definition to switch to
> hardware accelerator.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/split/split-accel.h     |  1 +
>   include/exec/cpu-common.h     |  1 +
>   accel/split/split-accel-ops.c | 11 +++++++++++
>   3 files changed, 13 insertions(+)
> 
> diff --git a/accel/split/split-accel.h b/accel/split/split-accel.h
> index 87a08454ce6..8a2888507f3 100644
> --- a/accel/split/split-accel.h
> +++ b/accel/split/split-accel.h
> @@ -42,6 +42,7 @@ struct AccelCPUState {
>       char pad[128];
>   
>       AccelState *accel;
> +
>       bool use_hw;

Stray.

> @@ -66,10 +69,14 @@ static void *split_cpu_thread_routine(void *arg)
>               }
>               switch (r) {
>               case 0:
> +                if (acs->use_hw) {
> +                    acs->use_hw = cpu_acceleratable(cpu);
> +                }
>                   break;

Why the conditional?  Why can't we enable use_hw here?

>               case EXCP_INTERRUPT:
>                   break;
>               case EXCP_YIELD:
> +                assert(!acs->use_hw);
>                   break;
>               case EXCP_DEBUG:
>                   cpu_handle_guest_debug(cpu);
> @@ -86,6 +93,10 @@ static void *split_cpu_thread_routine(void *arg)
>                   cpu_exec_step_atomic(cpu);
>                   bql_lock();
>                   break;
> +            case EXCP_HWACCEL:
> +                assert(!acs->use_hw);
> +                acs->use_hw = true;

Why the unconditional?  Why isn't it more correct to check cpu_acceleratable?

r~

