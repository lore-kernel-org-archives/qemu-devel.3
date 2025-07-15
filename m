Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CF3C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 10:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubd77-0006yq-2H; Tue, 15 Jul 2025 06:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubd6y-0006eP-GD
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 06:42:16 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubd6v-0005xR-MF
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 06:42:11 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a4fb9c2436so3212735f8f.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 03:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752576127; x=1753180927; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4Sv6g9HfR35Y7SsOH0Qvm1wQCEf28EHN1W//kKE6+A0=;
 b=n4Bzje/C+9hH+/wC3Enl7JiTQl/2X/TyAtDsM/vuK2r+uZNrWsXE7q9bDr2yWdr3Su
 AhvlQ0KpVEmAQ1n7GpZsAeBBKI5WjY1DJsMByYFhSsRaD3PD8jh8bUZfO5+7trjNCxxl
 I1zPwdvF5UwNQRcP6JoSx2DmKGvKRO4WQkpqKw1SFXAbWsDUucWggZGE8rmjgNYQ3NE8
 Demq7cCq0J54b2qp2wA9PVHoLmx7J0TahhiS36kApLqFNC8n7r5xA3Ar9ekZJBmkaayq
 OeeYZsNnT2dzcIyB4faAFr/jvY5usWzfRJfCyEleNFh7oMtl0zLm26mE9vkpX5arjN3v
 GDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752576127; x=1753180927;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4Sv6g9HfR35Y7SsOH0Qvm1wQCEf28EHN1W//kKE6+A0=;
 b=f+gBUSMZxEFvCTfMO7K1hAf0SYTuWa/JfsXA8m5gtQv8ZVkfzFTJSHQ1LH3P1dZv9G
 wnYQcKdPQ8bivatrvJAUWznf4UCh4XyoJ8qCxYR3/Fa/tpFpFNDa1cTlId/WDvuEdPSc
 jwZMu85WiL7x6nyH8iIyPQa9u18rl4BmD/jJrf8532nM4J9sR1Tt5oxDVx1saK8T+NOO
 uR6SyGP0/92Wd8AZjOhCKXfGbqXwQfUBB6EuXklRC24+2R3Im5+aSCceaOkyxw2zWWzF
 w9ZVt7p+9uV/aMyvh/2gjXv6ScxUgnYnv+f1nFlGs71BEqz7i8o8n0UEUzUGLkUNj+TW
 5jMQ==
X-Gm-Message-State: AOJu0YyPWY2djdDOlnpmRB3y+AHljx5yNvAdCveKi4956muYGMJ/9oAU
 z2iQzvY134hKrNNLHmiV0SPS/l4Y6Us+lA1ZegBslt8Y3LviZf8y1tgM8BnEUCtvUntJIlZmu4I
 1E92Q
X-Gm-Gg: ASbGnctc4AI1pdIIpZQf12YTHjkNm35mFa0ps2Vq5wLcBWxvoIHW8dzQayFevrJjx+7
 OJMmYTuU++jD8/iT+n1+ide/w7B2Vs9pd6Lv8qDhc+nEaTaEc24wRSs5992jdUJNZe8zIS5ywlk
 NeoTsNgvLOINPnrBoNIuCk/SkjLYQBzekofQ0t43Oh/1RI77jOiCIz09b36Ij5VlY9EkKIT/5VP
 B6rypLIcDjjGG3jKDel52Y+ra6WkvRDGhqkn2Cy9r77cmRWRv1hjdycLJxETxd/tdXHLXnf77B6
 4n2FJFR3FO0pWT/QWqb6g1SgN5iKImfxpdkFNipmN+QQDPAl10aqRt2fPOPeT9lrIaP/CxeSaa9
 cyuyaSDdMM2T31n+T1TxjO+tLGLv97WTTadEy/eT2c+10+agjaD1jeA9Tfa5xiEnRF9Bn76dmfK
 bwPSHh0g==
X-Google-Smtp-Source: AGHT+IEs8wPTUXoFeA6E8aH/1SgLeUszt4UWreJGe0iX9R4+K9Qwuee14Xm1eXQB3ch1G0siFS+3SQ==
X-Received: by 2002:a05:6000:2dc7:b0:3b3:ec10:75cb with SMTP id
 ffacd0b85a97d-3b5f1891e67mr14958258f8f.26.1752576127482; 
 Tue, 15 Jul 2025 03:42:07 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e285sm14589256f8f.76.2025.07.15.03.42.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 03:42:07 -0700 (PDT)
Message-ID: <59eb652f-50bc-4b48-882d-24febf2411a9@linaro.org>
Date: Tue, 15 Jul 2025 12:42:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v5 6/7] accel/tcg: Implement get_[vcpu]_stats()
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eric Blake <eblake@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>
References: <20250715104015.72663-1-philmd@linaro.org>
 <20250715104015.72663-7-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250715104015.72663-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Maybe "accel/tcg: Implement get_stats()" is a better subject.

On 15/7/25 12:40, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tcg-all.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index eaeb465dfd5..fc3f28e3532 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -236,6 +236,11 @@ static int tcg_gdbstub_supported_sstep_flags(AccelState *as)
>       }
>   }
>   
> +static void tcg_get_stats(AccelState *as, GString *buf)
> +{
> +    tcg_dump_stats(as, buf);
> +}
> +
>   static void tcg_accel_class_init(ObjectClass *oc, const void *data)
>   {
>       AccelClass *ac = ACCEL_CLASS(oc);
> @@ -243,6 +248,7 @@ static void tcg_accel_class_init(ObjectClass *oc, const void *data)
>       ac->init_machine = tcg_init_machine;
>       ac->cpu_common_realize = tcg_exec_realizefn;
>       ac->cpu_common_unrealize = tcg_exec_unrealizefn;
> +    ac->get_stats = tcg_get_stats;
>       ac->allowed = &tcg_allowed;
>       ac->gdbstub_supported_sstep_flags = tcg_gdbstub_supported_sstep_flags;
>   


