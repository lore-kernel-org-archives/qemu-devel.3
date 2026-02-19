Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B652CC531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 21:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtBMA-0004HH-P4; Thu, 19 Feb 2026 16:14:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBM8-0004G8-Kb
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:14:40 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBM6-00056Z-FG
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:14:40 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3549bba5302so814968a91.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 13:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771535676; x=1772140476; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NyfzGa0RWWP7xZSF+I+O81SuXmqwNZ3fFYDUswHfDvE=;
 b=HLF0wyp/x+UZAMeJYtjwn6Pf3E9oOZL7pyqq73V6oO/W6bdwXfwRF/BiqJsOp0cZFO
 0ohCk+CcR4AsbpFDpadKAYnYdlXx/0dPhqbcu8rMF7ufwNRJkpFckZRrlFDQ82xHFTaC
 xQiB7NhMjxWfhXWKMvob56mjSeR0pCSEMvQkcWR0OhrFs9y8hkLAFKc0U0oiMDY5EZLO
 GruOr5CG21t+UbWZXhiqYySz57zs4EEKj9GJ31xjaZqM+gig9cJ0ao/PwGaoaHsCPadY
 um9rngQqyLWsVp9OyXhvaBqBeQ/zV8bXXmoDsK2Za8ARm39+AlhMXSu7NlYrNqajxK0z
 Ov0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771535676; x=1772140476;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NyfzGa0RWWP7xZSF+I+O81SuXmqwNZ3fFYDUswHfDvE=;
 b=THIAhaTsDtzCx0chn9D7Z948z0boDamPc2iSLisCex+OhTkvQIYU45VDrLWqpsBRhA
 7YmD9RrXrvRma/AOHPRRV1882FKGV394jsc0JQOlFBrDrIABNw0z3EbsQ3bTVVk1Q9eD
 NxvPT5UxVGZnm2lMGj3NZa+5vceL6eqfwghaoDtqoukMBQ9qLF8CA1nJ6HlLseKS3xRP
 KzQSez5cTXat9cN64kAHhkUYiObf73oOEU3h+VYSvPNbQEwgTJnvrGkwrTin4x3FcsoQ
 RAeZpiX18i+sX62qXSufLO1vj949is5MCmeEsEzf0yRPWWAw+JT+bxH8mjBwvCyxqjMH
 PM4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxekEzmFiMAk6GQi/cMqUnkbXsUsgna2wl/VRxlyoO+8vBuETFdWlwEd1siAqFCDgRBrIRJp4XXzCL@nongnu.org
X-Gm-Message-State: AOJu0Yy95LuOtlWdb9hLQhATnG3fc5xkMq3HnZ+9r1mt6vhCsoXwttIT
 vd3vAdUqwOKG5Hp723+vAgZDMiyPF0eLmDOeB37o4g08kMHkb80jPi8TxrH/sKC02Lo=
X-Gm-Gg: AZuq6aIB7y4dOiY/Z3aHkpfRVSnexVLtZe25JwbJR4vZm3v8zp/wbgcObY2z6xNQo2B
 ttd6sYXVVPzeY+QqMkv/m4mSHXcQrJV9CaDwL0sOK4PdncCFY1ZHmka5nBNk/iv++KUB8s+XOGX
 XYAPyfMvAxJ3zNK1SHZrba7537pLHmhUnbXfTNsQ3CJC/WSWTTZ6dESWAhsHocmEQiQ3GdM8Oql
 HbNqJVYatUJFb9prw+peeaID0yCnpJFBvGYicc+BjmwQhSMoiHTP/01Btt0Z5VHFNYoz+r4hnQy
 Aia0en2zS+Wrw0hI2XV4ODjOOjQdq0MG6lRVEI1MxLyVq5bZ8ESVkQMF/7wAWWUuvXSRVYiP5gs
 rq2dYTyqgroys9PptUVCoaPd8ZgyLP3//oDpNA6kUEpZ1uNHZbJoH1jCbgqZ+ZydGrTP1aIRl/n
 whEs+DWQTPvGj89bprMXReQovC1822OE6bjZ0jfvr9SILznkLQMjQoSRwo+G7UN9yRraqV9PkFm
 x7wSq8=
X-Received: by 2002:a17:90b:2641:b0:353:f7b:6d60 with SMTP id
 98e67ed59e1d1-356aada48femr18144989a91.33.1771535675858; 
 Thu, 19 Feb 2026 13:14:35 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-358a2b3bfe0sm52969a91.12.2026.02.19.13.14.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 13:14:35 -0800 (PST)
Message-ID: <e2eb5bde-de27-41ca-bae5-d74a7f0072eb@linaro.org>
Date: Thu, 19 Feb 2026 13:14:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/50] target/sparc: Remove MonitorDef register entries
 available via gdbstub
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-18-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260219191955.83815-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/19/26 11:19 AM, Philippe Mathieu-Daudé wrote:
> All these registers are already provided by via gdbstub parsed XML
> and handler by the gdb_get_register() helper in the monitor/hmp.c
> file. Remove as now unreachable code.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/sparc/monitor.c | 107 -----------------------------------------
>   1 file changed, 107 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

