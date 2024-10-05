Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08690CF8869
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 01:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swtXT-0003hK-VJ; Fri, 04 Oct 2024 21:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swtXS-0003gN-2J
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 21:24:54 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swtXP-00066u-Rx
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 21:24:53 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71def715ebdso591010b3a.2
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 18:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728091490; x=1728696290; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c3C8AnkYs+qGMX7aDbM8uAjU99cDiEVXZhpALO/k3UM=;
 b=fXVCVc7FAVWQ5gwqnXHoT/RK1z/ETBKUXirm3Jc9ZkkcLQQ5ClWkbJdgZIHN/kNdS+
 9INQ1g/jP3KFhe99AfQD5rBjjgAZbf/gxd4i9NtGgRFXJPJ0MY6yqjft3RKs1HdAkHIm
 O7+felSDW5gX1kpEG6qisKXFAGlz3MJ20lQSMMGMIobR5eBbQfB4mr4oVYBJyD0/gQbz
 SHhbqHo9hMb9C3Do6wh6azprtYPSW6PhZQtioqDhoCpaSZs1wptpq6EXv827hXDRX65H
 POZLI3webvm+daueKe27z8etOaqq7VpJE5Q8ZmH69RwS1o6Bo/ISKEIIKMMQOlNrxyFe
 cuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728091490; x=1728696290;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c3C8AnkYs+qGMX7aDbM8uAjU99cDiEVXZhpALO/k3UM=;
 b=mzP6NVApgMCQE3UxXqp4lkvTnVUtprK7VInl56omdX5t9RjEB3UkWHHkv9ot6+wlUN
 pPRTgVIjWLVMt4mIAqF2+9gT9Rf04wfofdUjao9DUd8uzSj/+ahr9u4AWUoNCbarc/63
 3Pw/Sn7mN610LR8kPXo4mnMu0NRkUvWJSD+8xHTrmLcm140OxE3PaGqVk2mbW37f2+RV
 TSyzBoVPExxuHL4dg01aCrH+7srfUEQvl31I8Y5sawdmu6RuWcCD4v8ZZiGTqXN21w8s
 t4icmXQ/mswUqplh2Is+GTZNlEGB9uIWCtxbn8LtAdQT+xx0gCVlJzp7W+SYE3b6UR9E
 1BSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5pnCuyOytQ9wqew2vZ6dppI9QK+FElVF0TlCZCJp7aCUrWIGY1RO66BJUsePFrwQOhXq0fXbcI3zX@nongnu.org
X-Gm-Message-State: AOJu0YzAtDpqCL9HhgprwB4iCmtRg8EFa6y1R2K4sHSJQTqRhqBL93lu
 9g31fnwPiuwvmeyjClikS9G1Cg903vuT+ojDAzE2eruCfjWol2uYWotzh5r7k/Q=
X-Google-Smtp-Source: AGHT+IEmX1GCUwLgJ6TSIEUQS+3F5LCUmL+PgnRCFB61eHmB/30oohcCKsk2gonEp8GKDwsGrHQ7Ww==
X-Received: by 2002:a05:6a20:4e21:b0:1d6:e609:790a with SMTP id
 adf61e73a8af0-1d6e609795fmr2032724637.5.1728091490090; 
 Fri, 04 Oct 2024 18:24:50 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d6243asm506464b3a.151.2024.10.04.18.24.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 18:24:49 -0700 (PDT)
Message-ID: <0d80f1f4-a6bd-4f38-8f01-70273a52a67b@linaro.org>
Date: Fri, 4 Oct 2024 18:24:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/25] target/tricore: Use explicit little-endian LD/ST
 API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org
References: <20241004163042.85922-1-philmd@linaro.org>
 <20241004163042.85922-15-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241004163042.85922-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 10/4/24 09:30, Philippe Mathieu-Daudé wrote:
> The TriCore architecture uses little endianness. Directly use
> the little-endian LD/ST API.
> 
> Mechanical change using:
> 
>    $ end=le; \
>      for acc in uw w l q tul; do \
>        sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
>               -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
>          $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/tricore/); \
>      done
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/tricore/gdbstub.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/tricore/gdbstub.c b/target/tricore/gdbstub.c
> index 29a70051ffe..0b73b1280e0 100644
> --- a/target/tricore/gdbstub.c
> +++ b/target/tricore/gdbstub.c
> @@ -124,7 +124,7 @@ int tricore_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>       CPUTriCoreState *env = cpu_env(cs);
>       uint32_t tmp;
>   
> -    tmp = ldl_p(mem_buf);
> +    tmp = ldl_le_p(mem_buf);
>   
>       if (n < 16) { /* data registers */
>           env->gpr_d[n] = tmp;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

