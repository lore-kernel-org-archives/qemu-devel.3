Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C73D78337
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIA9F-0007uS-Fk; Mon, 02 Dec 2024 12:23:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIA9D-0007u5-T9
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:23:48 -0500
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIA9B-0008AE-Hj
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:23:46 -0500
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-46677ef6920so34595361cf.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733160223; x=1733765023; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bfEmpHRTHS6z9+6vo/qZSHUBLLwY7FXXDGYQQAX85nM=;
 b=n8OvZ/siB1zHaVGLHMtcFBpQOq2EafJvIBnA/uHebJxOQp/hsjR2HBI9/mBHT38dBb
 g8Za82NTSpGr0xJ84JXB98OIO7TA+0mehUu6xEECI78t+YyNYRqG8og9LIJL72fm+lps
 AmYnwArd4LWzS6/8W7QruXrpA5qRRkuu+Fz0gZzA5Zfp5o7BAc5ZZzRiD87S6hr24Y/7
 PYgzVt9r8RGPGzfnTekgUWftLNwqQPKKIrrrTr+Bq3U1j+6QJ3LVyf732SkU07OqkDQb
 N0Jp04BvpaNpJUhOqhYZBICBy9Mt2xj/ROpQMMxoVRkNqyT39XbZZAglSEZQRJDeCULc
 kM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733160223; x=1733765023;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bfEmpHRTHS6z9+6vo/qZSHUBLLwY7FXXDGYQQAX85nM=;
 b=eJOCPgK27QwKVScpdZWK/uC8/CRUrxP9wxSKIi5zFe9041XN3i+AhXfC3p3452TAWf
 O8TbpRyrvrJzRgEctyeeqDBudyXMri9gC3O0Kfzx0fRP6jQ9J7ydZHUGGOY5OGyYv9kO
 LfALn/W4BpL+fUY5Znkr/+zD7sNFFYVPiar5LAeNS1euugBEtNLZJQ51JT2qpQ49uBFh
 2fFdcycGtWYvuvUPrvbKpfgDCnwfnNKz3rVgVLoVJiBPu9AnaEG52tPueKk6EhHFgFtT
 W/C5z9rQR6vatKFzUjiNeK0oRnHN9D3W8hV8QDMCTKPdir61zvRggc4aSqXj+ab1fcro
 +QPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqZAV1Q8RhA8Kskdj5qnWMlMKKwXkwxfB5cNPOS/zIFKVLjp5SkjpFMsil9ZFCcfNossEuVGpHT0Ja@nongnu.org
X-Gm-Message-State: AOJu0Yy96t9TDgbMlcrblGGU+2Ca1eAyOtESYCcIVaiiVpxokzU62IGI
 SUj95EfQGuAZMCNHff7Bwc1OwcoT/F36kpagUBwNarouTSPqK47hkN9VB24JulA=
X-Gm-Gg: ASbGncvhUeJ8IDh4qupdqu1mRH8HvmI45m6ocL9WYKSkmrbx4gU0GjXf6sGp5dFFmwm
 FOfY+K1311nn734XHzAiom2neUgUzBbqVnn4RbsTb1DJFaJKvpzAh/4G/Dcw+1osKgMqoimnKuH
 uLmFS/jbJI2bsq0ROZ1w0++SDtNruLLkB7On/EZ8DnAeu7vERGFo/xJYrjpnuKDXq3L496w+L2l
 m/Vi6Wh/HVLKjOm26F4haVsS8+nxsvNz4NjUc0uXQnSjni/PwyGlRRxvyig0mMAwpCOB10=
X-Google-Smtp-Source: AGHT+IFzN9R7AoqFTxANtfNFEd5A7rbSF0xONfihs18zA2+FCtuLK+qH5ZA6IKeEBoiAFPcbaGWidg==
X-Received: by 2002:a05:622a:448:b0:460:dc96:27bd with SMTP id
 d75a77b69052e-466c1b4b4cfmr336760691cf.14.1733160223488; 
 Mon, 02 Dec 2024 09:23:43 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c421e339sm50544361cf.62.2024.12.02.09.23.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:23:43 -0800 (PST)
Message-ID: <65fdcb33-ca0a-4f13-8938-04f217cf8c57@linaro.org>
Date: Mon, 2 Dec 2024 11:23:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 31/54] target/m68k: Init local float_status
 from env fp_status in gdb get/set reg
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-32-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-32-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x834.google.com
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
> In cf_fpu_gdb_get_reg() and cf_fpu_gdb_set_reg() we do the conversion
> from float64 to floatx80 using a scratch float_status, because we
> don't want the conversion to affect the CPU's floating point exception
> status. Currently we use a zero-initialized float_status. This will
> get steadily more awkward as we add config knobs to float_status
> that the target must initialize. Avoid having to add any of that
> configuration here by instead initializing our local float_status
> from the env->fp_status.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/m68k/helper.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

