Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2FAC0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcxEK-0000t3-Sv; Tue, 28 Jan 2025 20:51:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcxEJ-0000r0-6P
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:50:59 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcxEH-0005mX-Gk
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:50:58 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-216395e151bso3301835ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738115456; x=1738720256; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hbSk5oKJOts5f7vjrSvodn2hpengGPHgyjMR1OGz05o=;
 b=fbt+DpX0zxtnmEZDVeYIbhQXPeiV6Vx92ejEMfcl2SpPy6EBFqiIQPnYxDB9hDOByh
 4FrEuE4Zvm1Psne9skCbPV2jTF8Wk+4Tuiw9fo7KpA64HoYHgQPWNRyVg5Tzx8doo6XY
 bCLHxYdUvnWsRnELJpIhrrWC50Pw2LkHSAnGRzg02kDszwTjDzjEiGgDhhvNpKuQke8X
 90Lez7HcsWLByyGP8ibHWCbZ7JFCjv6oBkdO9TKUICPeA3WJu+KMPP9DFnrZTl6xV4Yu
 4KonkC85oZtI1i7xej5byrbmIyINLKS3qIKq936REXg1Pch+T/QFQ0e++tOs2uNYzfcI
 mzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738115456; x=1738720256;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hbSk5oKJOts5f7vjrSvodn2hpengGPHgyjMR1OGz05o=;
 b=czFtonZ5vZXV6IHr6K2X01g8eWdLqYz1zjzhpLTAyO5sl2cxY87mBVIxwBRHmYDX75
 vgzyjbaXDDZsW3mivEvIc4UdfCPxThS614ib5NmrQlpuGOdIrC1AaGOyo5B388Vtlw0H
 rGEf548s3jLzVP4x9T+1GnL+MO7J0IinNZiqXAizpNQDG5l8ZjO2hDKJBx7wqGg3b5WI
 cPWVp5+imYLoCCB8kK4AThOzXE/YoAWs1QRKFqQJC2nBdGoMibQPo2B8EguLBBC0g0P6
 g5hJe87/S0vKTTbp+9nXuY276HiY8yuWvOFUe+fFOJfASVVJ6QrbPUwJjCNJwG057WA1
 yeXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV394HEXoXi8fF737XqaQ2IldN1u4hhPuFUqiyJkkidwHcgT9aZssihwAf01LDLWExvcFjDUCevdKsM@nongnu.org
X-Gm-Message-State: AOJu0YwqtTq5aMg+aQPfzXVCvKvuwuJ61BuUacokTtenrL67If6cD0y5
 /sD7YZpRku0/o0AfuL88TxMzIbX2+HW8TVO9FI2zbC/hAhkYzgX5NgDgJs8SXGI=
X-Gm-Gg: ASbGncsGpnMgyL6TnH5m4aVANtKkyXUnvR4OQv1oep6MR99pIlDBM/RqRWRp+SuiYlh
 uelMy9nMU5ewda3oDM+qfzzXR5hzGb/RV8JXURI3R187KXxNTULaAdg36mnq+c/TuhnW2hMeXhq
 rPEkdK7220y7fG4LW12Z21xSVw0nTWwswhwjpX1wXy04pTX5x9N7AYE3hWAHfbvqLWGcyKIDxmp
 q0N6FHadl08aFVWinLzp9MNcVEYSZAG04hnKJ6iqKwshNjNkVQ39Ac9c0IlUn6dRSZjMbZnB8Ri
 rM3B1y5XYg6OyrIZbv5aYPC3SHf4wvQgW2Rn9EhbsOuHovbe1MPscNJcog==
X-Google-Smtp-Source: AGHT+IH6DdXgWKpy95TqAwjnfh0hu9LFYA2+drgRWuYt4ls6RZIUzKVMA/Uu4/jXatV+9T/M4+fy0g==
X-Received: by 2002:a17:903:286:b0:215:9eac:1857 with SMTP id
 d9443c01a7336-21dcc43a636mr79278045ad.5.1738115455961; 
 Tue, 28 Jan 2025 17:50:55 -0800 (PST)
Received: from [192.168.0.4] (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da414cc20sm89074645ad.165.2025.01.28.17.50.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 17:50:55 -0800 (PST)
Message-ID: <a0d97225-f9f0-4765-bc73-4730d986d8b7@linaro.org>
Date: Tue, 28 Jan 2025 17:50:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] target/hppa: Implement space register hashing for
 64-bit HP-UX
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20250128224817.24715-1-deller@kernel.org>
 <20250128224817.24715-5-deller@kernel.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128224817.24715-5-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 1/28/25 14:45, deller@kernel.org wrote:
> @@ -4635,6 +4640,7 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>       ctx->tb_flags = ctx->base.tb->flags;
>       ctx->is_pa20 = hppa_is_pa20(cpu_env(cs));
>       ctx->psw_xb = ctx->tb_flags & (PSW_X | PSW_B);
> +    ctx->gva_offset_mask = cpu_env(cs)->gva_offset_mask;

This is invalid because no portion of ds2 affects tb_flags.
You can't just read from env.


r~

