Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3EBC36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 23:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txDIx-00062U-JV; Tue, 25 Mar 2025 19:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txDIs-00061y-Ff
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 19:03:26 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txDIq-0000my-Io
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 19:03:26 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39ac8e7688aso1041066f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 16:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742943802; x=1743548602; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IFOlILyxHsmwBnH5PeZn+nTFRFpUL1zLZnvSs1Hwcjs=;
 b=JMfU9/usNBDPN/UWYb6r2/SEEQ5b9TkAx1NXmhyyppjytfFpLNbXCpwYHptyvX6O7Z
 PUda7egAw9yKv7ERave0NgdTdDuzVDuiEI8m6BWXiUhVD3ZFdn/Xs/ZIWhg6oEz7ogdw
 cIJfr09hePgf2hKisdJQvQOWOqj+zM91d26OQ34cAKXkrZcoWH2KvZIwgXyRnO/PrGe0
 pRE6dAXfi747rc42tKjJJeiLG8I9gwtCxzer3CWNeBVxfX21F/xHHChcn6ziZxpOq+pG
 8XlMjchNuoi3hWzGmTFOUJZ4YSUwbmXV4GT3RzP3PsZW4rVENynLFryYbb31Uj6lM7Pu
 WnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742943802; x=1743548602;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IFOlILyxHsmwBnH5PeZn+nTFRFpUL1zLZnvSs1Hwcjs=;
 b=fXjeUs6TQbwmnxRJVNtNhVDC5oZv/ptwOtdV8zUexcfw3Pf2zOHHAgAIvhS5dwi8kg
 8BBWPFHPekr/LQFeL6tAH+O12LHFP+sTGp+hZ8AuDh8WXQS39em35NhfQrg9hTDcOwB0
 esLRUo2vAOVQC8xct9qsJQ7ExzwwfV/I6w6HehGesPjarEQctnKrtLFLhnnq97D/g/S+
 WNpAfK4Anu6QlJY+N87FCiMZ4O3QLM5ZDGENOOPT1FNzRctIleWzH6tAu5viFI6OsdD2
 E2DDVSsM7gzSwMx1kd07PJydKbpIB/lP20ZCYoCVCL9RddTGHW/inFewG2ZcDHvEm/uQ
 Oc1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv3oBvrO+5xdlJbJ40nTwo+bhBkH4MKyt5J5ewAMRKE4xEKPglvQcSqwYWE3hQuVucgy/DsVuW1zlr@nongnu.org
X-Gm-Message-State: AOJu0YwgYftviK3rqsk4RngOosFlP2xgjswCJi2D+5BbSxHMspn+j24V
 0ky3uqX/BsrwxitW0iueowcAgPlBd0yZh37wWa+p9YWmUlUxdj7PjW04pePo3Ig=
X-Gm-Gg: ASbGnct9JkjfQ9vZAeQe30gC4iDcP26vwQVcgSJDOheTrrEODfoG76zg6YDestcjPoJ
 BNo3XEQluxAWZOZqAxc3LYCbLemELGdGi7rQZ/S1Dij2osBV33ajxEgQzWvP2ckL/6tpexwOdP0
 J4z8qDaZmhTzU25EAkPLh9PwwdX8K0fi4MJ386hpzs++Ad/22jyDacGpwMaB2BmlAz3dvKD6W+v
 RLLNjwvibGZUdHIqbBaqu/LZOKSTw712tenVgjjOmTxa4YdjKyFGHiX9aTpOpXUbLEk1tAxTnBq
 WF8AqfS0SyYgx64hiJITwqhXvP6vZVdxyd3GzPM3K2fgWk3Tfx9Rs2FRvzdqKig7preRG1e4kMc
 HNcBc+7mJvGvz
X-Google-Smtp-Source: AGHT+IEBM6luPyNAwn/vy5QxM0XFkdfLDlccc+tg4A9EjYHfTzk9HLbS5UwSoFatn6SgCT859wHDEQ==
X-Received: by 2002:a05:6000:18a2:b0:391:952:c728 with SMTP id
 ffacd0b85a97d-3997f8ede02mr16288735f8f.4.1742943801597; 
 Tue, 25 Mar 2025 16:03:21 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e674fsm14740511f8f.80.2025.03.25.16.03.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 16:03:21 -0700 (PDT)
Message-ID: <292760a4-da56-43e4-b542-01631af347ec@linaro.org>
Date: Wed, 26 Mar 2025 00:03:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] target/avr: Remove NUMBER_OF_IO_REGISTERS
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, pierrick.bouvier@linaro.org
References: <20250325224403.4011975-1-richard.henderson@linaro.org>
 <20250325224403.4011975-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250325224403.4011975-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 25/3/25 23:43, Richard Henderson wrote:
> This define isn't used.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/avr/cpu.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/target/avr/cpu.h b/target/avr/cpu.h
> index 84a8f5cc8c..b49e7a7056 100644
> --- a/target/avr/cpu.h
> +++ b/target/avr/cpu.h
> @@ -44,8 +44,6 @@
>   
>   /* Number of CPU registers */
>   #define NUMBER_OF_CPU_REGISTERS 32
> -/* Number of IO registers accessible by ld/st/in/out */
> -#define NUMBER_OF_IO_REGISTERS 64

It looks used until patch #7 of this series which remove
the uses.

