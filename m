Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35181C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 02:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTAiV-0007Ro-2K; Sat, 21 Jun 2025 22:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAiS-0007RN-KH
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:45:56 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAiR-0007Hv-3c
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:45:56 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-235d6de331fso44139435ad.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 19:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750560353; x=1751165153; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dWK5nCj/j7XBIAquT2HAX95vHkEjLar22zTZrphDxNA=;
 b=m9Nse0/R1M+leT980cPX7+Cmw3praWRs9ZAHdMbkdvE9zgk8F4PVC668lRtqIeLko3
 ZlUfWAUMvbvBN/gcmkWOz/wl4aF83ETHCwWKuSQfpYjzaH3idT2eZR8V2qiYU+Y2TC2S
 AzRuewymw9jG38ccO5oP6IIQWR+PKaX1JiRQyPfdFLK7nTB9y1ZrrrsF/eybmT4Y7p8X
 bVCT85UzqRBfx3y84Q16AopiJQLy1Lt3VIAOW3+VQOuLETlXf2n679sulNtB9d3bqc2S
 WYzvp+bTleR7mVeSRlxsuhapCvbXICupP98D7EIW6UAW4VodoUPOBTaUlaEqLyu0Z5Ft
 /eRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750560353; x=1751165153;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dWK5nCj/j7XBIAquT2HAX95vHkEjLar22zTZrphDxNA=;
 b=kT+i2odW/M+OEvb/MY7vPGYimQYAAsjQJXvtpCOSHSRjqQiS3t/U/cUGllnsgQYAcD
 nOKsbGKtbp3Z7QS1tQZlhERrld0G7xLrXICRde0TNR1UA/6uui430EJeIVHTbyTecADT
 D7xcvs8vlfFfl1eWergwe152mtzN6iBReMEiU1gyHqPqGY6D1ru9BUjc/uf3kQYezR4j
 CQmPoC58XOCF371zmNvSgd0f5c7az8Pm3riTxks9YM2o7v6eQiTTIg8g2v5fSy/nHTja
 8bWOjidsmw6LUDzLVRX/pbVpbGk8rhEpZg2ErD93Ve1gh5GNvgO0E4cdr1NcSLO5I52L
 4S/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsMe4d71eBDX0d+2/M6CKTYMHCrly5ATNCsEwgUwQaQ5bB7Nf2okS5ahiB6hgNLlbtIXEkLFbckvry@nongnu.org
X-Gm-Message-State: AOJu0YzimAPbsJg6sfqc+NYEA4kAP3c0OQ8CRNufhMtbCN+GC9uAiQj8
 LXD6nKR5rr470d8cjOeJOwB+hP7LCmPihKUGEBEoj3bv3W9bQRI4hfOj5b1wCMS4o8U=
X-Gm-Gg: ASbGnct0nwjxDbkFxa+UpvwbsmB/JWCvg6nylFXQm4RUh7l8fXU9z5kKsim5jiyawoj
 iHR+gl+Xnb4UmASdNlhkQw5u+1Mx4ijYjZzQlqABWx3bCEDsZzDt9wUoj4PeWQe9wEcH5o4ZjTQ
 is8O4z17+yPAtr2GDo9RKNVol+cAosnY1Z6Lr1eJcNxayKWTrhgTtFylduXVn9JTORyIC2Oh/t+
 MNsrzJ8fciOOFqFHAoN9R1ec2YmFXj0UJu8VM1S0W8Hq+t1gd9iNczLIVKUwnd28Rq/igNln2fq
 nnPSCYk1o/JQnuwlVLm3OWWy9f25Y/0C4itV8IwcyrFg6v/a97LlNhp0bY+24xk+W1JaahzYpNJ
 Lo1Rw2ZKaVJd/o8RR4ve//C4wW97tEzg5ee+nw6Q=
X-Google-Smtp-Source: AGHT+IFfXoWEYXpTV6z/pQKwktAZ+FZGmjhwZE+G8PRsVKPJrCmRRltPcYN+jyiFyQHgd9Os6N+BKw==
X-Received: by 2002:a17:902:c94a:b0:235:ef67:b595 with SMTP id
 d9443c01a7336-237d9acc6e7mr133067065ad.35.1750560352966; 
 Sat, 21 Jun 2025 19:45:52 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d860a761sm51015085ad.122.2025.06.21.19.45.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 19:45:52 -0700 (PDT)
Message-ID: <1b16b519-381a-45e9-b37a-10dd4c98d366@linaro.org>
Date: Sat, 21 Jun 2025 19:45:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 12/42] accel/split: Have thread routine ready
 to dispatch over HW/SW
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-13-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
> @@ -49,10 +56,12 @@ static void *split_cpu_thread_routine(void *arg)
>       cpu->exit_request = 1;
>   
>       do {
> -        r = 0;
> -
>           if (cpu_can_run(cpu)) {
> -            r = 0; /* TODO: exec_vcpu_thread() */
> +            if (acs->use_hw) {
> +                r = hwops->exec_vcpu_thread(cpu);
> +            } else {
> +                r = swops->exec_vcpu_thread(cpu);
> +            }

Maybe

   AccelOpsClass *curops = acs->use_hw ? hwops : swops;
   r = curops->exec_vcpu_thread(cpu);

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

