Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5199C0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWk8-0004JX-Nm; Mon, 10 Feb 2025 11:34:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thWk2-0004HN-OQ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:34:41 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thWk0-0004ux-Ts
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:34:38 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21f48ab13d5so73400865ad.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739205274; x=1739810074; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oojInHLen1wwEyuauTOfvFgnAUxJJ+ej5wUFioz+P6c=;
 b=BiFxHGoKexpLY56Hrggvid96qps3nP96eD1POgBlTGW3k4GzD7U483pvZxbvAo4C7w
 1+aWmgFzyn/w9YH5yA2hJe3siTze4LLySulWEW0sNWoozIn+9OCPnE1lzioA0dnQ9aTq
 g68jmUncvNsQJNxxZNa+a5KSG4tBGxqK/6zwTxD1c6VljOTCoNUPiCYYWfyrvcbKUFq7
 79FvQsBJtTGDWd/BAtCmtV2x1nZN+qiWhpAZSo9K3xTcqwnPbDum6Q59CapWxHwL4Xwn
 u6onjEfKIcdSuJT8KtJck4RTZhJLqJZGUZXYLFRSX03LrL5NuwXmqTD1dRZC9fRgav3v
 3L6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739205274; x=1739810074;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oojInHLen1wwEyuauTOfvFgnAUxJJ+ej5wUFioz+P6c=;
 b=uZRCvjGWIHf0EqPN7JrCrKQoAjafp2WGOlyDAmcgZJIrjRJ8CZDtrisFWDST5GDfEo
 tCG8fWIN4WCouGlaR7XhiRKVQM/K+5O3fxo1RDdqko7hq2XktMewzTjeNMNanRMIHIWm
 +4+Q6akuYKoAL0JoDCFsmBexaHPbAUb7DARP/6nbunR7JgcoZm4zmGl0qoS6rwyl0aiU
 f7HtpL97aXR61jGq0tCoaEEv6NsXBnkofLoZZiAVY7lsOIzgaaIcnvjp9DVBMwkv9p+F
 oHd1hICPN6v7uKW6ikK4Og9Rsde4QoGkOiMRPucbV/A5z4IzCPsRza77kUaMdAz742aG
 WXMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa4g97NlxlhNhD/svofhMfo97vQ31wuUWjQkcNWQsig5BBnOHHmidpVzQZf1WXFLYIkjWzmdAzJGTE@nongnu.org
X-Gm-Message-State: AOJu0YztjXi7DiucAueSbSPdv+Tm1dTuTUVXcUGhWxaHkJursL9EXfWT
 D6df4jpsLexZTHr0WON6mSNSZuNiXC2B+P3ekj6uI+ioZM1+Pp/etIVWr7OH7sA=
X-Gm-Gg: ASbGncvTruQdtjaxo2e1nRXRY/R9ZDKKTGltPT8/TrA3KkP+yo+9YXmxXdufaSQlyb0
 c9wr/w2SVZUFpV2OLWHhA0poq+dQSGWPCgNWUrnB2uNG3o++WwJ98zlu6SleeVhEjM9z/bg0K78
 5Vu3ysl6FFy0MlhAvR+vDYi96IJDJ/2vuvnVXZzykueor7YECamMzzaF4qgIwSrAWEQGXqKeh8u
 JNFPmBLNRhgZnFVIqX58Eg9El2Q7mcPmFeOiQ1aUTaPDMtnVpqWi8ZR7dHjlVs+Zb6kk+6YQwj0
 LVsraVFdGsrN8890z7KrSD1vYqoYfv8vqhzJjTIQPb1YCGDTIxLxIPE=
X-Google-Smtp-Source: AGHT+IGMRc9QXr2h84SI+n2YGjjt0UpgZKDaONytT/yDP2iNXjgMQG9k2uyXWdBZfTZCpZHDNM7qCA==
X-Received: by 2002:a17:902:ced0:b0:215:e685:fa25 with SMTP id
 d9443c01a7336-21f4e6bf3femr201445075ad.20.1739205274510; 
 Mon, 10 Feb 2025 08:34:34 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3689b5ddsm79633655ad.216.2025.02.10.08.34.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 08:34:34 -0800 (PST)
Message-ID: <7d62c69b-b0e0-4f61-9b7f-2c700291431d@linaro.org>
Date: Mon, 10 Feb 2025 08:34:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] target/riscv: Convert misa_mxl_max using GLib
 macros
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org
References: <20250210133134.90879-1-philmd@linaro.org>
 <20250210133134.90879-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250210133134.90879-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/10/25 05:31, Philippe Mathieu-Daudé wrote:
> Use GLib conversion macros to pass misa_mxl_max as
> riscv_cpu_class_init() class data.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Cc: qemu-riscv@nongnu.org
> ---
>   target/riscv/cpu.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f3ad7f88f0e..9fe1b23a297 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2955,7 +2955,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
>   {
>       RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
>   
> -    mcc->misa_mxl_max = (RISCVMXL)(uintptr_t)data;
> +    mcc->misa_mxl_max = (RISCVMXL)GPOINTER_TO_UINT(data);
>       riscv_cpu_validate_misa_mxl(mcc);
>   }

I guess this is quite a bit more explicit about what's going on.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

