Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50061CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 00:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulcnb-0001hK-Ng; Mon, 11 Aug 2025 20:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ulcnY-0001fz-If
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 20:23:28 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ulcnO-0006dw-Vl
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 20:23:28 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-76bc68cc9e4so5084934b3a.2
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 17:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754958193; x=1755562993; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IL8M2Yphs1uWuyDpLgAemSi0lzpgFGx9Axa3XmY9pRU=;
 b=vSVLSFbAufEBHK9ELNlDnkmmEooWLC9qT4lHZ8ALaKq47p5rfXJKv4FthACYR0PY2A
 3LKAuT9fvO3W2cKd6ooXmrxof0dkTk4P8GKTw7/p8cDmck4LItV6T9Kvkd2Wevckpe46
 KGxM0S+cyHbrjjYkFyp8d4NczcjNx2aqwaTYxixkJgwGgnIV8lsD9dozX+r6TL+0etFH
 D/SXJ1skp+UgOwaDE72b8xykg+8TKeyAoih7AVvuE0VnktBM2IMuy7fMgjQgjqlj/A2v
 OcQzMFXrDmDZrpLmwiJdOvLyaEHdlplocUSEfFoqSwDcDtUHco1N78IWqDrxhPZLKBsX
 GQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754958193; x=1755562993;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IL8M2Yphs1uWuyDpLgAemSi0lzpgFGx9Axa3XmY9pRU=;
 b=BUF4tFrEbJjFZxTinW89S605EhERPyzfDFBVZhuc0yd7UNIb7NfkaWJ2TVJO1oEK+Q
 DHE+ZK6geLWzq5LWQqrlrojnnUwSXmlmhm/iie6j5dF/jPEwdawoefchCwj2d3iZL14o
 Yx5xSCleXtlga3+AMzHIzFxB+2dJmgxwflqg17yS5/s7Br7yV1BONCNVErwtmwe58138
 r30WFJ7S8CLD33b3jpTR13T1R5hAnXrp5K+gQzfzr9vrMCLhv1QioOuCr4txvzC/PDtf
 M/iuQGxXst/ZtvuhgICUCrSODDpST/UAdMDT6j6/Wl/5gMiO43RwUJK6HK8QPbPKYTGG
 f0CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMIJgPegxl4SvBlv9V6ZQggZBC93rnc2IGckZB/qI1vcYvo6A1aM3GiPANbb7wQpbHQoVR7NmKYzud@nongnu.org
X-Gm-Message-State: AOJu0Yw9RHCxEVFObmbWLjFXGoTkEqr/octrRpuL1hEeTam01LMCAGkU
 fqeN2enfkKZdqdRlAxoobUnVfmqkgoZj3gkB2TrtPVlltuX8jZq/AHWcSJLAQTvpTjmrfLLCrpC
 vegQe7Fg=
X-Gm-Gg: ASbGncvVpZfpd+a6JEEkcthEf4oq8Ly0o5mz9yUxsaaVnSqszNO5L82v3OUzpTVTAwD
 h+9S8hsOoXWJ3w35XAvGJxTyUUzrbg1proZPxUqrFBXTFTyZSY1bMOeuyWqKj9T+mPEKUfw6N6P
 jZ+S/t9jYohmk/7YstYQh9uQ8V+/UMwzAG9uJEy5BfCu4qafwgEeml58WchhcZUOBnw6xeA+fRN
 KcOV4cM2gjzhswe0gWIVavghG6duPgk2l3n38qanpiG8XkQuUX4iL1WzbR0hKJlmpdcAltfZeVV
 lPe2QXGn/4SQqD6LtwIujcSRCAGJkYBtJAD3kX1he14YGc9teemnYLvOy52kRdxyn6ryFozspBu
 PCDaruOQjiU2nmH5TFOyt/0b110atyM+GEpnTIwIUKw==
X-Google-Smtp-Source: AGHT+IEsRSvDYeVJnXksTlrNRFc9hk8LKbzNMrgTbBdo8H3iFn95T8qEdlYr3zXEnpUVAoc0mYdW+A==
X-Received: by 2002:a05:6a21:3287:b0:240:1f14:f6c5 with SMTP id
 adf61e73a8af0-2409a9c2583mr1940684637.32.1754958192886; 
 Mon, 11 Aug 2025 17:23:12 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b422b7bc91dsm24179524a12.19.2025.08.11.17.23.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 17:23:11 -0700 (PDT)
Message-ID: <99d1910a-2572-4cd4-b6e1-e874a0992bbb@linaro.org>
Date: Tue, 12 Aug 2025 10:23:07 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 11/11] target/arm/hvf: Allow EL2/EL3 emulation on
 Silicon M1 / M2
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250811170611.37482-1-philmd@linaro.org>
 <20250811170611.37482-12-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250811170611.37482-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 8/12/25 03:06, Philippe Mathieu-Daudé wrote:
> @@ -1014,11 +1015,14 @@ bool arm_hw_accel_cpu_feature_supported(enum arm_features feat, bool can_emulate
>       case ARM_FEATURE_GENERIC_TIMER:
>           return true;
>       case ARM_FEATURE_EL2:
> +        if (can_emulate) {
> +            return true;
> +        }
>           ret = hv_vm_config_get_el2_supported(&supported);
>           assert_hvf_ok(ret);
>           return supported;
>       case ARM_FEATURE_EL3:
> -        return false;
> +        return can_emulate && tcg_enabled();

Surely the el2 portion needs the tcg_enabled check as well.


r~

