Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61318CCD1BF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 18:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCj1V-0008VZ-Hb; Sat, 25 Oct 2025 14:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vCj1T-0008VJ-Ex
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 14:29:51 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vCj1R-000332-IJ
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 14:29:51 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b4aed12cea3so276805366b.1
 for <qemu-devel@nongnu.org>; Sat, 25 Oct 2025 11:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761416987; x=1762021787; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8OBbSNq3SKGchaEDkpfJegXyjMzuNGP4MZN82Vq68r8=;
 b=hmwRPsk6tKCLclWLmES96j21vk74kafMkuXLhOwNwQx9grwqcevtJljwJsSF3TBxS+
 fZ8YsYMuR+hVHtn7bX8FB73M+ibXEKAfMa+ErYyhs3vrL72tDYg2fS+e1kQiKrOFwvG/
 1z5cSlxEtj2al4XpZCEb2kBFjbOz8CqHYILhsa+xKZKmahkEs2lrLeQCiUAhKUM1itmZ
 +9dsmniwp0MVlxUHhFqgQaN02EAunOS8eC5nqn8W6UKT0QmcruAG/dE5MaIJ8R+uu+m/
 3S5ELBUWqfo3HGGcTQSieKopNQcLCPXVPzoGaayEEzqsaf2PlNYWYPRz/HJyqg0kqmCl
 P+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761416987; x=1762021787;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8OBbSNq3SKGchaEDkpfJegXyjMzuNGP4MZN82Vq68r8=;
 b=Xcgo3TVs1hKJefm0ktyVkdydRhSLlMXKOFxeyJEL0FAkW8xWJvi83ZiAR0e48Bx0KX
 jFRFe9cv5nz2hHGQwUabcEJvrK16bKX+AbLM6doN5SBr5H1meP4Ngb2L+ZSbyp7sD7uW
 zjwS8eloUOQnL2xGDo03sZWY2Dy1rFt/aLri9hDl/jir3WmF0yaN3Vnlo2iw3Sg5Gme4
 TfHzWMsbypNkuwHfIrLivHwYdimX05D3DarFHb2wU5FAb/1utAzYCjKkQP6yYyCV1qia
 kxjLSmw3XBHIlYyHbUJXhcwVleM4dSIjCxkDsUgro+Y4PmZRf5SAoI/Vyx++VWNu/nr4
 pvtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkv5q68DfUEcvSCedTDR/t3EbKCXmhITsnncYz0xogFKesVRs7Wz3G4/5PD7E6/XvGuYFlGyLkvwUI@nongnu.org
X-Gm-Message-State: AOJu0YxNYMZKakNvwA2tQZx+of5p98d7kcNeP1a/6ZBI5wS4BoKwabgl
 9jZ9uVBBs1hY/fR4YcltcOVc+3FNdY8hOf4cW8IChvbvImFhNCih1jyXJfwotp/CIRA=
X-Gm-Gg: ASbGncsTu1xxSDrWLbxxo4ZSlVxP1e+NPZG8w0KLextLtxsBgvCon4BaczzZJ8OzyVO
 eOlJVgheyM3bNgiahaypWqT9d+fKjbxx+uSlN0v9neBq5zRTNeW1cMaONknsJP5f6p4g95CU5ut
 pTdLSN9rA2MpiMb2K4ha7ZoTBhtj+v5D2ZMr6m8ZzUonxibiL3FZtOGQJpC2vQF5aiOGBxaYEnm
 a6I+XVg1qdUvoHoCZgurphT3Jd3fz50SimMOeXt6N/ou4k6GwabbdGpUPemXFev9ZXXg10snOGE
 GFKdeBNNSxumtd/tW5riaFSgsqAsf94ObPrCFC2NwhRtwzsAl2scFiSvHixNdfxBO3rQR8ujwuX
 NMxPpynt87bSVvRKheu3vrjAFCNNUae0FS7JXy/XVWUw8LSNRgWdvSYReh4sWXF7ufUMxehYxTh
 oLFVY6mab0YM0UiPgKBgcZ3xU6dM7rdLYTS7wBc+/s7HAN4xlIjNLai6kxBQgk5y8=
X-Google-Smtp-Source: AGHT+IFpR8cF2Z5aljTNvU2LjgNbXZCT5+wmhIW5WNKM07PQnBU0lWQV3aXn2OXrvk+hcf1WknRLEg==
X-Received: by 2002:a17:907:3f12:b0:b6d:5718:d42d with SMTP id
 a640c23a62f3a-b6d5718d6c6mr987400366b.50.1761416986692; 
 Sat, 25 Oct 2025 11:29:46 -0700 (PDT)
Received: from [10.240.88.227] (ip-037-024-071-028.um08.pools.vodafone-ip.de.
 [37.24.71.28]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d85308cb0sm265477366b.9.2025.10.25.11.29.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Oct 2025 11:29:46 -0700 (PDT)
Message-ID: <c8a521bb-8130-4dde-914c-7d96b056994d@linaro.org>
Date: Sat, 25 Oct 2025 20:29:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 44/58] accel/hvf: Have WFI returns if !cpu_has_work
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Stefan Hajnoczi <stefanha@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Collingbourne <pcc@google.com>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
References: <20251023114638.5667-1-philmd@linaro.org>
 <20251023130625.9157-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251023130625.9157-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x635.google.com
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

On 10/23/25 15:06, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index cf4746c344a..8c2eac6738f 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1749,6 +1749,13 @@ static void hvf_wfi(CPUState *cpu)
>       uint64_t nanos;
>       uint32_t cntfrq;
>   
> +    if (cpu_has_work(cpu)) {
> +        /* Don't bother to go into our "low power state" if
> +         * we would just wake up immediately.
> +         */
> +        return;
> +    }
> +
>       if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIQ)) {
>           /* Interrupt pending, no need to wait */
>           return;

cpu_has_work is a superset of the interrupt test.
The interrupt test should be removed.

r~

