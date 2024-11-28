Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AA4D70DE9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 17:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGidj-0005po-I3; Thu, 28 Nov 2024 12:49:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGidh-0005pV-6h
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:49:17 -0500
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGide-0003GB-J0
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:49:16 -0500
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b1b224f6c6so75584285a.3
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 09:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732816145; x=1733420945; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XE6utzElCMqegzidcsnJBE3JXKyBVzvrl+zhqU1mcpA=;
 b=MHlljcdygdzjWEapLEIxoQGYUskGWd0DWORKpXoPaP63RFkcFVjjedlu4AWRi0d7lG
 qZfofXVATSQNwulP7wOEQp+xD+EoAw2NPIWiFwXhZYOVFmYvywPHWyy+Col/jNRd1gfH
 tw0KQGiDndYDPoPxYvd0JjXNOyj3XKE5Xm8VEAYfc7us5nnMAAaCxyEWFNjyBwFMoPwM
 5mFoBuCFOJ+rNk64TTW9faucJ/SJwaLUQZX+4XlfH8jRXgdibDD5O7uUIbH5JzpyaLe8
 Ytr+2q5xpgyUDaYwe9xeMF9YGsTAomAojOvZLNljvu/qEaIndrtS6eZ5SmfHPvYOB8IF
 XeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732816145; x=1733420945;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XE6utzElCMqegzidcsnJBE3JXKyBVzvrl+zhqU1mcpA=;
 b=MiQ0ulKODuGSTWwU2qBc5lbRRBeV9u3pV1LhMG+pa9WNhv7jt3J2HtCkOWY71M3RUd
 adTa/VIfetW+h+VQ2XphytnK58417Q2VYdSdabdL/nwf0tSK9e6tN6jH1VsybpcsAmX7
 U0DODlaMKTVfHE7bKXGxgWvbISnxOdMZzzOyduTGQ8lvKhEr/bcQGDXe3edofWKiFHXt
 HuMvEki9xt5lkmXNQLzezs2LmsIbTLD8J129iul1dW7Jx28usM/r9JodUqTARrn/POPG
 pDbQPNNS0hVxGcQ4ns2An69SuxDyNvW6PelVICDk2o3pzLvwCITb33ZOe4UmCOY59ZY7
 QX6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnnr8oxKQIIOSk4wXjfTQ8E3yHtOjOWbNp7cF6T2cav2HBkzNIeMmVbtNtxh9NFlmNxLez72C3i95f@nongnu.org
X-Gm-Message-State: AOJu0Yz6Mt220OPHBp34dBsc7uLqyQPtH3p86epDiYWWKyEfjLX7sN9f
 HhVxacaQXlBJRmy/4+nzUR/XiaH+UfWtKM0LUThSMkKACWpPVDlF9G0Pqhqx+5I=
X-Gm-Gg: ASbGncs9WKQPymmYOk6zmKzlg+1a0uiJoYPV6pro2T08TOLjT4Yw9nfs0G7Is4EaJ79
 aTaOyY2zoal+rqzmc42fd/gT1XIUkA+AbgSvVHq7HXbAL44E06Je6S1owirHfHmJsKItQ9SXW23
 RDicvnaADBIVc5LyMScNE1DBI0KLpykprWhgUAwB1JfbH9/de32y2nPyFMCuz1HlhLUXn+mUUMR
 sbgEh/9yko61Pgoua/sycxFpMwknwXSmdDJn2WwWk9HCYW0GZdo4vDXq2GFuQP0CpY=
X-Google-Smtp-Source: AGHT+IFI+Q32ODC18SvDrnuR8txaHN2obPoi7W/PCTCz6ISwP8H5n7YIJInnrTJHkwmei2v+w+7mJQ==
X-Received: by 2002:a05:620a:43aa:b0:7b1:3e41:8495 with SMTP id
 af79cd13be357-7b67c463da4mr1048719985a.48.1732816145169; 
 Thu, 28 Nov 2024 09:49:05 -0800 (PST)
Received: from [172.20.3.167] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b68492114bsm75498985a.9.2024.11.28.09.49.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 09:49:04 -0800 (PST)
Message-ID: <c76875d8-a581-46e2-a01d-da260ff0be3a@linaro.org>
Date: Thu, 28 Nov 2024 11:49:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0 14/25] softfloat: Allow runtime choice of NaN
 propagation for muladd
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
 <20241128104310.3452934-15-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241128104310.3452934-15-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72b.google.com
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

On 11/28/24 04:42, Peter Maydell wrote:
> +/*
> + * 3-input NaN propagation rule, for fused multiply-add. Individual
> + * architectures have different rules for which input NaN is
> + * propagated to the output when there is more than one NaN on the
> + * input.
> + *
> + * If default_nan_mode is enabled then it is valid not to set a NaN
> + * propagation rule, because the softfloat code guarantees not to try
> + * to pick a NaN to propagate in default NaN mode.  When not in
> + * default-NaN mode, it is an error for the target not to set the rule
> + * in float_status if it uses a muladd, and we will assert if we need
> + * to handle an input NaN and no rule was selected.
> + *
> + * For QEMU, the multiply-add operation is A * B + C.
> + *
> + * NB: we don't list all 12 possibilities here or implement them
> + * in pickNaNMulAdd; if your architecture needs one of the missing
> + * combinations you should add it.
> + */
> +typedef enum __attribute__((__packed__)) {
> +    /* No propagation rule specified */
> +    float_3nan_prop_none = 0,
> +    /* Prefer SNaN over QNaN, then operand A over B over C */
> +    float_3nan_prop_s_abc,
> +    /* Prefer SNaN over QNaN, then operand C over A over B */
> +    float_3nan_prop_s_cab,
> +    /* Prefer SNaN over QNaN, then operand C over B over A */
> +    float_3nan_prop_s_cba,
> +    /* Prefer A over B over C regardless of SNaN vs QNaN */
> +    float_3nan_prop_abc,
> +    /* Prefer A over C over B regardless of SNaN vs QNaN */
> +    float_3nan_prop_acb,
> +    /* Prefer C over B over A regardless of SNaN vs QNaN */
> +    float_3nan_prop_cba,
> +} Float3NaNPropRule;

Oof.  I was imagining a bit more data driven solution, rather than explicitly enumerating.

For instance:

FIELD(3NAN, 1ST, 0, 2)
FIELD(3NAN, 2ND, 2, 2)
FIELD(3NAN, 3RD, 4, 2)
FIELD(3NAN, SNAN, 6, 1)

float_3nan_prop_abc = (0 << R_3NAN_1ST_SHIFT)
                     | (1 << R_3NAN_2ND_SHIFT)
                     | (2 << R_3NAN_3RD_SHIFT),

float_3nan_prop_s_abc = float_3nan_prop_abc | R_3NAN_SNAN_MASK,


FloatClass cls[3] = { a_cls, b_cls, c_cls };
if (rule & R_3NAN_SNAN_MASK && abc_mask & float_cmask_snan) {
     do {
         which = rule & R_3NAN_1ST_MASK;
         rule >>= R_3NAN_1ST_LENGTH;
     } while (!is_snan(cls[which]));
} else {
     do {
         which = rule & R_3NAN_1ST_MASK;
         rule >>= R_3NAN_1ST_LENGTH;
     } while (!is_nan(cls[which]));
}
return which;


r~

