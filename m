Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7108D7833C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIAKn-0002iQ-49; Mon, 02 Dec 2024 12:35:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAKl-0002eF-7z
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:35:43 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAKj-0002w0-Jw
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:35:42 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3ea5e405870so1784016b6e.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733160940; x=1733765740; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KYRbuOnEnvGaK/Sm1MTr80N5TAkvfbJGir9gusPXArA=;
 b=pLbSV7Px77h2miqvAiGLmy+Ths5bKyMBRytK3jouRP0Z6lZ2Bsm6UL1+eGnDIerovy
 HTao1C7/X+b43qOkuzM+XATVBBoazdT4Jjk3GqfoANTjTum9YKcIUjQT64PVZBa6Bg/P
 Zz8m5RrUXx/s3mAaUdu5BiROTHEmBA7a195xE6WgW6UZZgRH/5+SuGpI+LYGWCKz4GgB
 mHZDDJUwWKBxiitqRDLV5q2t/2BmKzCRHsLDGcvq4Hvgnh0AySenwlcMSEebRDAhwQ+0
 lwgxTmjORSpnBiMkawRaXTZMY4fmgtY1vfUDWIasyL7W0yqWDTluASFkTB6VLKIsHOXQ
 2alQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733160940; x=1733765740;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KYRbuOnEnvGaK/Sm1MTr80N5TAkvfbJGir9gusPXArA=;
 b=n4cGx5NGARK8hSlLu5d3wP0TnHHhFP/Ww2y1a9H/fJOfqcF9KE8F6xmTATuzSbXodn
 +rIFsPBRPqajP9I2ezsdsnftSU48JVHFMjxOznnIqaCbv5Lz/4GXkNgAB4qxsD23i7ap
 svU2VacB6PPBrb4xW2eGBVgmYOhX1+SvxJFDFVdW8DEOzabfsw2gei9nzr8i1p1dBrbk
 d0VMWv3IIJWuiOk+8L/T+UlHlmCVfwyUqt4Zt5ieTiue/osBaTdqDrq7GstNfLEnE5Au
 KYg7VvNQ52MqCslXjguP9q29Qgt2SlNIbD9FQ8nKftuUEtc7dN7LEYtiz4NzoaDS7rXa
 4WGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwkRrhOnKZXsjlfPo2prAQ0FulG9ad7zUBS6onSrsM7Ny4elt2rttQEmhBwG/bJHXWUPkJfPhCPRJZ@nongnu.org
X-Gm-Message-State: AOJu0YyCQuw0rV1/ziPXqo70VTvJ40F4T7h5q3lh9pCP/tZ8MaCe17h+
 RflyHoCx5ARpNGplEPU0h54FrvG06bNS44wHfrEYTt62XokyJVkmx//dsO+tRwiIwkeA2DG2yH5
 I80E=
X-Gm-Gg: ASbGncvq2S3ijY/J5HYR7WDYxtPKnI9mqh9LyURed76pBhjlVu7ViGtbitxMOwPnmnL
 pKk9S9GvDWwPXqln/8eixiGqmFzaOb/MQAoSqQknZY4us7l86Tz5jkOF3KSc89ZbgCvfk4z0LJO
 vCPEccIVPnpg6zxX5mdOcJYOeqJ2Muz18obmTCLCgf1ctP56pnGZOLjSGRIGrClASYciD6kN2Br
 dW89m89FTdR6afS4VwoJ7hynXIKgLpVoJy5sCTXjx1M8Rj810zf4/G2dpRUus9sO8FFxac=
X-Google-Smtp-Source: AGHT+IGdYVdMUpjCGahWSyMQ8DAmFa9URBfGGfl/U2jWq/TPw36NeKNF5uiyf2kNmLNLeVJ1gPn2Jw==
X-Received: by 2002:a05:6808:1486:b0:3e6:143a:fadc with SMTP id
 5614622812f47-3ea6db8f180mr20338026b6e.3.1733160940434; 
 Mon, 02 Dec 2024 09:35:40 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea8621a7edsm2396060b6e.38.2024.12.02.09.35.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:35:39 -0800 (PST)
Message-ID: <93e9e3e2-f206-42e0-9d83-3c1daf75d61b@linaro.org>
Date: Mon, 2 Dec 2024 11:35:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 47/54] target/rx: Set default NaN pattern
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-48-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-48-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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
> Set the default NaN pattern explicitly for rx.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/rx/cpu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/rx/cpu.c b/target/rx/cpu.c
> index 65a74ce720f..69ec0bc7b3d 100644
> --- a/target/rx/cpu.c
> +++ b/target/rx/cpu.c
> @@ -100,6 +100,8 @@ static void rx_cpu_reset_hold(Object *obj, ResetType type)
>        * then prefer dest over source", which is float_2nan_prop_s_ab.
>        */
>       set_float_2nan_prop_rule(float_2nan_prop_x87, &env->fp_status);
> +    /* Default NaN value: sign bit clear, set frac msb */
> +    set_float_default_nan_pattern(0b01000000, &env->fp_status);
>   }
>   
>   static ObjectClass *rx_cpu_class_by_name(const char *cpu_model)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

