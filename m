Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAE6CD4F49
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 14:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOyuo-0007yi-27; Mon, 18 May 2026 10:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOyue-0007tI-9h
 for qemu-devel@nongnu.org; Mon, 18 May 2026 10:25:47 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOyuc-0004fz-MQ
 for qemu-devel@nongnu.org; Mon, 18 May 2026 10:25:43 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3695bf7d082so2153017a91.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 07:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779114341; x=1779719141; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sLK+jfLWTUHUfTz0p8BoFzW2DtvYjZT5d9MHKks/3UQ=;
 b=Hkb5hwL3o9oRRJLuecByXsc1C5kybK0SVHhyWMknJUYaSIHM9JzdL5TWOuX+XXBpce
 Czh2OcxuWbvgGFUX1+hbUZi9lYj6IDmu4+SeFyuBfK6+KmK+sFjHaop9Ujpsb2wzkbqI
 lKeJjCDsqAMDR3kWj/J35ss3Qazw1y0U8RIxto/Av3ozuXgSuqkToi3ZkKTn6BNMDThI
 rgAjthplncbopq+9FbXkYeRFwWzmxbbakMVTXrVl2lH9JBydLklHWCz3FCkHGquA1ao8
 kcp7r35RC5DCM1vlFkyS73KR35X06dW6cMYsavCybPrQ22EOI4X24xoo6r5N4315pct9
 WvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779114341; x=1779719141;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sLK+jfLWTUHUfTz0p8BoFzW2DtvYjZT5d9MHKks/3UQ=;
 b=kTcqEipjDUb4sVKcm38x5ElcZG3w2mkTuEBCYWdnLZj+nwYiD1OURRvih+hFbmtA5X
 psOM6ftPzE4zcUzXvyzozUgi2RgsxHW1mz3dKfC4tNCFr9hQGnAhtFbfduwI4annkPMq
 iOX7S4v2np3izTZ6pVpAWEJpNlFC2A9yLaJZg3553qg5jieL0hE+ad3/ZPVtlBqxbr+a
 Z33r9wKDRUtr3hGvdVkB8DGsqDeHi3F3T9SzsPhjCDONy474hBqjhcQPHVYf8TPnebJH
 cLh6fO9VMYG4MQtZiT1F12jkcunGrSS6wsh8jZtkcoUgJtC7WpkVHQFWwhCr0WvKPQYt
 5ONg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/6c73uRCmiBGeWcyPSEFwjbUs98V7alQBupyk6SjGArEaoh9QZZXIK7Q+0DTzYle4n2d7+P5nKtWqD@nongnu.org
X-Gm-Message-State: AOJu0YwpIbhgsnwpjdOZQj2FS7GO20tmyosIn/qqQUXIMKiR7eQmiy2Z
 y1P2/AzS07HMa0l1tIT7J5OyBhY91Lw0Mxsr6bl5SiOPWDE0TxMRhsOk3elKkEUVb5s=
X-Gm-Gg: Acq92OGscctAeJPk95RcXlEEsOKUVaeBx95YOTl+of4f+cGpsLlFBD3jOj9pZnZnXN3
 BR4IRFq7XyYu2czexB5wuKZB4fIFloTS7Je73rWkO9tOx4vKINdHoNLh1JFyZ1Mk0nakEACxaSk
 LWvu+rnle1PfQYv69zgqGOWqsIg70VyGyX+fu6cEeMVdKxeUsreM7DKq9Kgl9QEKQh1XcGw9auT
 jwjUubgdCROoIx5E3+jGRs3XH/Tk4hYH3eodW4ISDrlbV82KihMZsNpSRD1hqRSN584jewj09kD
 G53Ze6rzd1dP9DhH4VTSnCWBpPjd4eEtaXJ/ilLHevZVEe6C5KmFSY8f0KKSncgICiWtXJTCarc
 xi/qKrbFqd0PMj2viYa1UW6PK5Cx1/AMcL3vMFMhVGRDbVR4W+8eF2Jj+VndTudvwYk6io+jQVQ
 fET91IL9PNYbZhY6YYQc5xHiLaT6fP78zoSyf/
X-Received: by 2002:a17:90b:1c82:b0:366:4782:1379 with SMTP id
 98e67ed59e1d1-36951c9a00fmr16247317a91.24.1779114340813; 
 Mon, 18 May 2026 07:25:40 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-369517d8570sm11766124a91.14.2026.05.18.07.25.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 07:25:40 -0700 (PDT)
Message-ID: <d28477c0-ed15-47d3-9e47-2bb70e2ff423@linaro.org>
Date: Mon, 18 May 2026 07:25:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 19/35] target/mips: add Octeon VMM0 instruction
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
 <20260517-mips-octeon-missing-insns-v2-v8-19-206151ee77ec@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260517-mips-octeon-missing-insns-v2-v8-19-206151ee77ec@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 5/17/26 22:29, James Hilliard wrote:
> +    for (int i = 0; i < OCTEON_MULTIPLIER_REGS; i++) {
> +        tcg_gen_movi_i64(oct_p[i], 0);
> +    }
> +    return true;
> +}

Oops, forgot to re-use octeon_zero_partial_product_state(),
which I removed in the middle of re-working.


r~

