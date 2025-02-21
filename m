Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B44C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 13:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlTGf-0006nC-4W; Fri, 21 Feb 2025 08:40:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlTGd-0006mp-C1
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 08:40:35 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlTGa-0003vR-Vi
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 08:40:34 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4398e839cd4so19104095e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 05:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740145231; x=1740750031; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9uAidROf9fm3NZr+vHDI7NGHdlEkcPXLaAyADVLbmkM=;
 b=ZNBt7HP2haLoogaCt+SvpwFcW7owFM1MY5XvqlHZMoPuy6+PJUrdZ7vlaKQZVj6R9E
 pZn2ROMTFcaNW+3T3t/1e4cHW5h0Towp3TqzBb1zlg+CJmwKueYJfuR+5mEatHNH7jWC
 5k6415ih7AfeLZMEwMM7OLS2qsrXtloY+APT38eAt3CenQc6a3nzQb6zF3aezh6iwr45
 lWYUoXyyo79iu12sxqnN7mojbJ7tJti61PnaKEiLYbM/xl7oD4wGCEMkMrhnkKnKOKFh
 dC2dqFo4RxZDYTm1Pj7TGpq90mn+D7VnEGNO2L/RlujwKJ9AVO7nwY9KN93kYMX5fgJz
 75NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740145231; x=1740750031;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9uAidROf9fm3NZr+vHDI7NGHdlEkcPXLaAyADVLbmkM=;
 b=TyswzBTNmafCSTo2VdAHElsltWyEmGWvfoImePrZ9kaF4OmVDlMj3r1Wv//bRSxYdi
 lZ+vFwdg+5j7vwfIIBz5fn2bQWC1t64i+P2lYkUfslhJzPwhM9EbSwQfjYYVH+gg4/WC
 bZZg75lGVeyiGsPv6YNZkAfI5nrVjAqtHENEUCbCgkYvNfh/5Xvq3aUfBHDzNUq7sbP/
 O2BCx0K+OGSwzHzSCEs7J8tEUoDOjwNYLJtEzhshLNKryVHf6q7/rm3gjZ3Ds6MrQ9VD
 f0R2pfVhBcoDhYk3ilmsfnoihNZeYWdgG4PAxrKaSPIAJbVMxbd9SWmfutcKIDYYMIr1
 BOBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJUEYAonKNSxlrNE8W+s1Ju1NF3X/HEAQOvbjmKCKRAN+G0DYNCt8bNIKlRKcASFE42DBIkckJz7LO@nongnu.org
X-Gm-Message-State: AOJu0YxzUPZIa6kw4bbmQLPAR/XTnLNoBpejMN09hKHvTw+vZIVF3rPa
 +45yEneaYrquzHOA50B9NqUZbY1+CCGFNn8Z4r4kn4k+xsD5/tsVNGbo5OWF3/U=
X-Gm-Gg: ASbGnct+P1yXqYmlPb6PuSYvXOquCPQsm3sGResDXjFZqO+w55OQEgR1JpH19yWvFPQ
 Zkm6y47ynIpy6M2+9XKkHG6mYcWik/NnEQUjtGDClZffVy0vqSRyGQm2eGCCbGRKmBk7VLvacF7
 hNMInhMM4HK7zb5uZ4JvPt3AWLTiFpGy6LZD7YzcXUxKY6nR5a7yn3Z5zEVAqdHREquSLhoqiCM
 vKDqT8nR2B4h2I0JsI895MKAIciuFgWZllp6e0jAfay0ZCOgNW0CH1X+EWCXnbXCRg99mLT3rT6
 xRrOErGWIVBiTMCRkuINFLCSNPwCFdV3A8Q5zknXl/67m/qRSnRjcTi8Ln94hPbtUUmTNg==
X-Google-Smtp-Source: AGHT+IGQZXLwzHVsHw5Us6G775urn+iHBf2A6HFx6CZHCd5+asrAHx5kk5beC033t11alnDKsWtbrQ==
X-Received: by 2002:a5d:5f90:0:b0:38d:c6b8:9fe1 with SMTP id
 ffacd0b85a97d-38f6f51d885mr3031257f8f.24.1740145231269; 
 Fri, 21 Feb 2025 05:40:31 -0800 (PST)
Received: from [192.168.69.157] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f25a0fa38sm23829943f8f.98.2025.02.21.05.40.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 05:40:30 -0800 (PST)
Message-ID: <cea9380d-1217-4814-ac35-dfab51375d28@linaro.org>
Date: Fri, 21 Feb 2025 14:40:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] target/i386: Avoid using floatx80_infinity global
 const
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
 <20250217125055.160887-4-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250217125055.160887-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 17/2/25 13:50, Peter Maydell wrote:
> The global const floatx80_infinity is (unlike all the other
> float*_infinity values) target-specific, because whether the explicit
> Integer bit is set or not varies between m68k and i386.  We want to
> be able to compile softfloat once for multiple targets, so we can't
> continue to use a single global whose value needs to be different
> between targets.
> 
> Replace the direct uses of floatx80_infinity in target/i386 with
> calls to the new floatx80_default_inf() function.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/i386/tcg/fpu_helper.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)


> @@ -2358,9 +2358,8 @@ void helper_fscale(CPUX86State *env)
>                   float_raise(float_flag_invalid, &env->fp_status);
>                   ST0 = floatx80_default_nan(&env->fp_status);
>               } else {
> -                ST0 = (floatx80_is_neg(ST0) ?
> -                       floatx80_chs(floatx80_infinity) :
> -                       floatx80_infinity);
> +                ST0 = floatx80_default_inf(floatx80_is_neg(ST0),
> +                                           &env->fp_status);

Which expand to:

{
   .low = floatx80_default_inf_int_bit_is_zero ? 0 : (1ULL << 63),
   .high = (((uint16_t)zSign) << 15) + 0x7fff
}

Effectively equivalent of toggling the sign with floatx80_chs
(the floatx80_chs removal was not obvious, worth mentioning?).

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Review note, as softfloat API methods names are verbose,
float*_chs() could be renamed as _change_sign().

Regards,

Phil.

