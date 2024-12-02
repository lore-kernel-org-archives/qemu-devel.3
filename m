Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBDBD7833D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIAJt-0001Xx-Cc; Mon, 02 Dec 2024 12:34:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAJe-0001Vi-94
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:34:37 -0500
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAJb-0002RI-6x
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:34:33 -0500
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5ee8eaa1694so1967775eaf.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733160870; x=1733765670; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3vLn4ULweqRA3w0r5aR40h6JNt8JnBrr55Dq4flOSyk=;
 b=pjS7uxMwB+WZHjAOdLiNk2P3kRZTA/4F/c3zGwdXLACDsJkt8dVc6ltpWYnJsDoqLP
 tgyqIxyO1C37Gz/cLRM7ueUAF7zauhP6OoZOaU4yKtzChdYpr6qCDlpe0CGoAd1G/FNK
 H87zC2dGbyyYo5jxnMRbg16+o9+slNPe9CtBXLNy7Goub8xBhh4xLmYZ81ddHyTuTL8n
 jpUgiorznlZ4el3hPY8xJGQXQCg3L10kSIQJF4BlVMORi96I4qbweLz5sw8F+WpiEMk/
 tWeEhDECtwdbuLvC83TbbFUak0hoNIX32sa0cHbBEa/sGLrM3+dykuP2yHqCBhKENND9
 Tsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733160870; x=1733765670;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3vLn4ULweqRA3w0r5aR40h6JNt8JnBrr55Dq4flOSyk=;
 b=LwTG0FhEALGIOn6it2twXwqHEOEVfTQDSFR638phZBeNqlSHMWJlxILiLcUYtoSdBZ
 ax6mQmTDd7rAz+568KFjVIhv0blWPTe2cikQ6d3I6cCNQ2YH71p9Mlt/g3NDSQ4/ghZI
 XNh7b8jhbUWC5zNMGM1HZ7rCJ/fpp+7ngKq/K1bgUXXgk8YGsxqJHBPAAPHIhkXeOxGI
 C3CZXHaWIF8aLICkXwakEyg5Brbtq6cYA8rKT+7EfKnoZmSWDrOSHEqtWTL70ooQOcHy
 4xTHC1gJRg1J7fkCg8Q68P0YWHq/HWb5YfWY76fRsi1lKlQZ0xV3v+i42JdwGQPxPHua
 80cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeGdxtp8e5scpP9fRDB4VMhsBZ5dz2kbv0dPQpMhdRpqCO2VM1UQzhZTevGFR9eqvG5pNTptZXZmy2@nongnu.org
X-Gm-Message-State: AOJu0YzZGaa18rk79aGy5MDd0DVhMGTKsJcBaEFi+3fuVDRBQCaK1TSb
 e4NQLGTIJtJAA2RmocPEUFyogL0DT3LEU5wlaMaaN7LEo1y5A966qMUq3vZ+O0Y=
X-Gm-Gg: ASbGncsfwgBmog5hrhFs+86sBppu7uO4TlgGZDYuom85eWvkSWlgU6sIGDGy+4wCSoR
 o8who6IZdvK1yFkMAB+/R2aCYMJjRmW4lcOz+Ghbebwigxi6mEUvq2FKzbtEc5JzdCeH2hht6if
 G7UIrZPsz4WP5l9xW23a2klRGnG+Hi9hwRq/jdpFBKIOXArjHW0mo41vLdKx2cHhJ96c1GJLLHm
 OCH8EvXE59jZoAukeid+sh0EXtqy7xsxQOkFYwTBnNl86sgC2hqFzXbzfRCreh80+PPNvA=
X-Google-Smtp-Source: AGHT+IEFO2ZFj3m3UVbDVQ117WK5R8Z8r1JWbzQ6dRoQAXhC+k6uGq9J3xc/tkVOyHIqt24VjbkYsg==
X-Received: by 2002:a05:6830:f89:b0:710:f375:a6c9 with SMTP id
 46e09a7af769-71d65c93264mr15834555a34.7.1733160869853; 
 Mon, 02 Dec 2024 09:34:29 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d72427c3fsm2385188a34.8.2024.12.02.09.34.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:34:29 -0800 (PST)
Message-ID: <29402c15-151a-4e70-8c2b-4daac8c792c6@linaro.org>
Date: Mon, 2 Dec 2024 11:34:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 45/54] target/ppc: Set default NaN pattern
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-46-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-46-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/2/24 07:13, Peter Maydell wrote:
> Set the default NaN pattern explicitly for ppc.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/ppc/cpu_init.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index eb9d7b13701..1253dbf622c 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -7286,6 +7286,10 @@ static void ppc_cpu_reset_hold(Object *obj, ResetType type)
>       set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
>       set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->vec_status);
>   
> +    /* Default NaN: sign bit clear, set frac msb */
> +    set_float_default_nan_pattern(0b01000000, &env->fp_status);
> +    set_float_default_nan_pattern(0b01000000, &env->vec_status);
> +
>       for (i = 0; i < ARRAY_SIZE(env->spr_cb); i++) {
>           ppc_spr_t *spr = &env->spr_cb[i];
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

